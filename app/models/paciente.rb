class Paciente < ActiveRecord::Base
  belongs_to :pessoa, :dependent => :destroy
  accepts_nested_attributes_for :pessoa
end
