# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def formatar_telefone(telefone)
      "(#{telefone.try(:codigo_area)}) #{telefone.try(:telefone)}"
    end
    
    def link_to_remove_fields(name, f)
      f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
    end

    def link_to_add_fields(name, f, association, template)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(template, :f => builder)
      end
      link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => 'botao')
    end
    
end
