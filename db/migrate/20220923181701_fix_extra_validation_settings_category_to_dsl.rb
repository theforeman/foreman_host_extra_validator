class FixExtraValidationSettingsCategoryToDsl < ActiveRecord::Migration[6.0]
  def up
    Setting.where(category: 'Setting::ForemanHostExtraValidator').update_all(category: 'Setting')
  end
end
