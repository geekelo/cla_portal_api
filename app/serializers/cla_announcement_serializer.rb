class ClaAnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :cla_cohort_id, :cla_user_id
end