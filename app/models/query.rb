class Query < ActiveRecord::Base

	### CONSTANTES 
	enum kind: {query: 1, category_kind: 2, random: 3}
	### FIN: CONSTANTES

	### RELACIONES
	has_many :results
	### FIN: RELACIONES
	
	### VALIDACIONES
	validates :kind, presence: true

	validates :words, presence: true, if: Proc.new{|d| d.query?}
	validates :category, presence: true, if: Proc.new{|d| d.category_kind?}
	### FIN: VALIDACIONES

	def mail?
		send_to_mail.present?
	end
end
