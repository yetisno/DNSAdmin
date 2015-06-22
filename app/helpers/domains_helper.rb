module DomainsHelper

	def nav_tab_head_tag(type)
		query = type.to_s == 'member' ? 'user' : type.to_s
		link_to "#{type.upcase} #{content_tag(:span, @domain.send(query.pluralize).count, class: "badge nav-tab-head id-#{type}")}".html_safe,
		        ".tab-pane.id-#{type}",
		        aria: {controls: type},
		        role: 'tab',
		        data: {toggle: 'tab'},
		        belong: @domain.url_name,
		        fclick: "domain_show_#{type}_list_load"
	end

	def record_delete_btn(type)
		link_to 'Delete',
		        '<URL>',
		        class: 'btn btn-danger b-delete',
		        belong: @domain.url_name,
		        sfunc: "domain_show_#{type}_list_load",
		        method: :delete,
		        data: {type: :json},
		        remote: true
	end

	def record_add_btn(type)
		button_tag '<span class="glyphicon glyphicon-plus"></span> Add'.html_safe,
		           class: 'btn btn-primary b-new',
		           data: {
			           toggle: 'modal',
			           target: "#frame_domains_show_#{@domain.url_name} .tab-pane.id-#{type} .skel-new"
		           }
	end

	def create_form_tag(type, &block)
		form_tag send("api_domain_#{ type.is_a?(Symbol) ? type.to_s.pluralize : type.pluralize }_path", @domain.url_name),
		         class: 'form-horizontal',
		         belong: @domain.url_name,
		         sfunc: "domain_show_#{type}_list_load",
		         method: :post,
		         role: 'form',
		         data: {type: :json},
		         remote: true,
		         &block
	end

	def create_form_cancel_btn
		button_tag 'Cancel', type: :reset, class: 'btn btn-default b-cancel', data: {dismiss: 'modal'}
	end

	def create_form_submit_btn
		submit_tag 'Create', data: {disable_with: 'Creating...'}, class: 'btn btn-primary'
	end
end
