class MobileVisitProduct < ActiveRecord::Base
  belongs_to :mobile_visit, :foreign_key => :mobile_visit_id
end
