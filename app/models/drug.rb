class Drug < ActiveRecord::Base
  belongs_to :drug_category, :foreign_key =>  :drug_category_id
  def ingredient
    temp = self.name.gsub(self.dose_form, "")
    return temp.gsub(self.dose_strength, "").squish

  end
end
