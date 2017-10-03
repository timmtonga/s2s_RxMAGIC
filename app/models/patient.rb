class Patient < ActiveRecord::Base
  def fullname
    (self.first_name || '') + " " + (self.middle_name || '') + " " + (self.fathers_name || '') + " " + (self.mothers_name || '')
  end

  def first_names
    (self.first_name || '') + " " + (self.middle_name || '')
  end

  def last_names
(    self.fathers_name || '') + " " + (self.mothers_name || '')
  end
  def formatted_pnid
    id = self.patient_identifier
    return (id.blank? ? " " : (id[0..3] + "-" + id[4..6]))
  end

  def nat_id
    (self.national_id.blank? ? "N/A" : ((self.national_id == "N/A") ? "N/A" : self.formatted_nat_id ))
  end

  def formatted_nat_id
    return self.national_id[0..3] + "-" + self.national_id[4..7]+ "-" + self.national_id[8..12]
  end

  def age
    age_in_days = (Date.today - self.birthdate).to_i

    if age_in_days < 31
      return age_in_days.to_s + " días"
    elsif age_in_days < 365
      years = (Date.today.year - self.birthdate.year)
      months = (Date.today.month - self.birthdate.month)
      return ((years * 12) + months).to_s + " meses"
    else
      return (age_in_days / 365)
    end
  end

end
