require "csv"

puts "Load Drug Categories"

categories = ["Anti-thyroid", "Pain", "Vitamins", "Statins", "Neuro/Psych", "Dermatology", "Cardiovascular",
              "Pulmonary", "Contraceptive", "Endocrine", "Opthamology", "Miscelleneous", "Gastrointestinal",
              "Infectious Disease" ]

(categories || []).each do |category|
  drug_category = DrugCategory.where(category: category).first_or_initialize
  drug_category.save
end

puts "Load Drugs and their thresholds"

drug_categories = Hash[*DrugCategory.all.pluck(:category,:drug_category_id).flatten(1)]

CSV.foreach("#{Rails.root}/db/drugs.csv",{:headers=>:first_row}) do |row|
  drug_name = ((row[0].to_s rescue "") + " " + (row[1].to_s rescue "") + " " + (row[2].to_s rescue "")).squish
  drug = Drug.where(name: drug_name).first_or_initialize
  drug.drug_category_id = drug_categories[row[4]]
  drug.name = drug_name
  drug.dose_strength = (row[1].blank? ? nil : row[1].squish)
  drug.dose_form = (row[2].blank? ? nil : row[2].squish)
  drug.save

  unless (row[3].blank? || row[3].to_i == 0)
    threshold = DrugThreshold.where(drug_id: drug.id).first_or_initialize
    threshold.threshold = row[3].to_i
    threshold.save
  end

end