require 'redmine'

plugin_name = :redmine_ckeditor
plugin_root = File.dirname(__FILE__)

unless defined?(SmileTools)
    require plugin_root + '/lib/redmine_ckeditor'
end

if Rails.version > '6.0' && Rails.autoloaders.zeitwerk_enabled?
  Rails.application.config.after_initialize do
    RedmineCkeditor.apply_patch
  end
else
  Rails.configuration.to_prepare do
    RedmineCkeditor.apply_patch
  end
end

Redmine::Plugin.register :redmine_ckeditor do
  name 'Redmine CKEditor plugin'
  author 'Akihiro Ono'
  description 'This is a CKEditor plugin for Redmine'
  version '1.2.5'
  requires_redmine :version_or_higher => '5.0.0'
  url 'https://github.com/gk1220/redmine_ckeditor'

  settings(:partial => 'settings/ckeditor')

  wiki_format_provider 'CKEditor', RedmineCkeditor::WikiFormatting::Formatter,
    RedmineCkeditor::WikiFormatting::Helper
end

Loofah::HTML5::WhiteList::ALLOWED_PROTOCOLS.replace RedmineCkeditor.allowed_protocols
Loofah::HTML5::WhiteList::ALLOWED_PROTOCOLS.add('data')
