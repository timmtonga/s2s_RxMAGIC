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
end
