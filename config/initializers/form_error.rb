ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at('input,select,textarea')

  model = instance_tag.object
  error_message = model.errors.full_messages.join(', ')

  html = if field
           field['class'] = "#{field['class']} invalid"
           html = <<-HTML
              #{fragment.to_s}
              <p class="error">#{error_message}</p>
           HTML
           html
         else
           html_tag
         end

  html.html_safe
end


##TEST
# ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
#   fragment = Nokogiri::HTML.fragment(html_tag)
#   field = fragment.at('input,select,textarea')

#   model = instance_tag.object
#   model.each do |i|
#     single_error_message = i.errors.full_messages.join(', ')
#   end

#   html = if field
#            field['class'] = "#{field['class']} invalid"
#            html = <<-HTML
#               #{fragment.to_s}
#               <p class="error">#{single_error_message}</p>
#            HTML
#            html
#          else
#            html_tag
#          end

#   html.html_safe
# end


##Test 2
# ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
#   fragment = Nokogiri::HTML.fragment(html_tag)
#   field = fragment.at('input,select,textarea')

#   model = instance_tag.object
#   error_message = model.errors.full_messages.join(', ')

#   html = if field
#            field['class'] = "#{field['class']} invalid"
#            html = <<-HTML
#               #{fragment.to_s}
#               <p id=single_line_error #{error_message}></p>
#            HTML
#            html
#          else
#            html_tag
#          end

#   html.html_safe
# end

##add an id and add to the bottom of the form before submit <p id=single_line_error #{error_message}</p>