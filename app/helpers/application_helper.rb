module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def gravatar_for user, options = {size: Settings.avatar.size}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def get_pagination_element_index collection, element,
    page_elements_count = Settings.pagination.size

    collection.index(element) + 1 +
      (collection.current_page - 1) * page_elements_count
  end

  def link_to_remove_fields label, f
    field = f.hidden_field :_destroy
    link = link_to label, "#", onclick: "remove_fields(this)", remote: true
    field + link
  end

  def link_to_add_fields label, f, assoc
    new_obj = f.object.class.reflect_on_association(assoc).klass.new
    fields = f.fields_for assoc, new_obj, child_index: "new_#{assoc}" do |builder|
      render "admin/shared/#{assoc.to_s.singularize}_fields", f: builder
    end
    link_to label, "#", onclick: "add_fields(this, \"#{assoc}\",
      \"#{escape_javascript(fields)}\")", remote: true
  end
end
