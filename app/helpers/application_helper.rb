module ApplicationHelper
  def drug_categories
    DrugCategory.where(:voided => false).collect{|x| x.category}
  end

  def dose_forms
     JSON.parse(File.open("#{Rails.root}/db/app_options.json").read)["dose_forms"] rescue []
  end

  def dose_units
    items = JSON.parse(File.open("#{Rails.root}/db/app_options.json").read)["dose_units"] rescue []
  end

  def languages
    items = JSON.parse(File.open("#{Rails.root}/db/app_options.json").read)["languages"] rescue []
  end

  def has_prescribe
    YAML.load_file("#{Rails.root}/config/application.yml")['has_prescribing'] rescue false
  end
  def facility_name
    YAML.load_file("#{Rails.root}/config/application.yml")['facility_name']
  end
  def user_roles
    return ["Administrator", "Pharmacist"]
  end
  def report_options
    return [["daily", t('forms.options.daily')],["weekly",t('forms.options.weekly')],
            ["monthly", t('forms.options.monthly')], ["range", t('forms.options.range')]]
  end
end
