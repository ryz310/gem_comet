# frozen_string_literal: true

module GemComet
  class Release
    # Creates a pull request for release preparation
    class UpdatePR < ServiceAbstract
      include Thor::Actions

      def initialize(version:, base_branch:, version_file_path:, changelog_file_path: nil)
        @version = version
        @pr_comet = PrComet.new(base: base_branch, branch: "update/v#{version}")
        @version_file_path = version_file_path
        @changelog_file_path = changelog_file_path
      end

      private

      attr_reader :version, :pr_comet, :version_file_path, :changelog_file_path

      def call
        update_changelog
        update_version_file
        bundle_update
        create_pull_request
      end

      VERSION_NUMBER_PATTERN = /VERSION\s*=\s*(['"])(.+?)(['"])/.freeze

      def update_changelog
        return if changelog_file_path.nil?

        pr_comet.commit ':comet: Update CHANGELOG.md' do
          version_file = File.read(version_file_path)
          current_version = VERSION_NUMBER_PATTERN.match(version_file).captures[1]
          inject_into_file changelog_file_path, after: "# Change log\n" do
            generate_changelog_template(current_version)
          end
        end
      end

      def update_version_file
        pr_comet.commit ':comet: Update version number' do
          version_file = File.read(version_file_path)
          version_file.sub!(VERSION_NUMBER_PATTERN, "VERSION = \\1#{version}\\3")
          File.write(version_file_path, version_file)
        end
      end

      def bundle_update
        pr_comet.commit(':comet: $ bundle update') { `bundle update` }
      end

      def create_pull_request
        pr_comet.create!(title: "Update v#{version}", body: '')
      end

      def generate_changelog_template(current_version)
        <<~MARKDOWN

          ## #{version} (#{Date.today.strftime('%b %d, %Y')})

          ### Breaking Change
          ### Bugfix
          ### Feature
          ### Misc

          #{Changelog.call(last_label: "v#{current_version}")}

        MARKDOWN
      end
    end
  end
end
