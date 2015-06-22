class DeletePtrsDomainId < ActiveRecord::Migration
	def change
		remove_column :ptrs, :domain_id
	end
end
