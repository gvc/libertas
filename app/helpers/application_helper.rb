# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def select_with_groups_from_hash(object, method, choices)                                            
      name = object.class.name.downcase
      html = "<select id=\"#{name}_#{method}\" name=\"#{name}[#{method}]\">"                             
      html += choices
      html += "</select>"
    end
    
    def option_groups_from_hash_for_select(hash, group_method, group_label_method, option_key_method, option_value_method, selected_key)
      hash.inject("") do |options, group|                                                                
        group_string = eval("group['#{group_method}']")                                                  
        group_label_string = eval("group['#{group_label_method}']")
        options += "<optgroup label=\"#{group_label_string}\">"                                          
        options += options_from_hash_for_select(eval("group['#{group_method}']"), option_key_method, option_value_method, selected_key)
        options += '</optgroup>'                                                                         
      end 
    end 
    
    def options_from_hash_for_select(collection, value_method, text_method, selected)              
      options = collection.map do |element|
        [eval("element['#{text_method}']"), eval("element['#{value_method}']")]
      end 
      options_for_select(options, selected)
    end
    
    def formatar_telefone(telefone)
      "(#{telefone.try(:codigo_area)}) #{telefone.try(:telefone)}"
    end
end
