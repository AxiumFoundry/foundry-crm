module AdminHelper
  def admin_nav_link(label, path, icon_path)
    active = current_page?(path) || request.path.start_with?(path.sub(/\?.*/, ""))
    css = if active
      "flex items-center gap-3 px-3 py-2 text-sm font-medium text-white bg-white/10 rounded-lg"
    else
      "flex items-center gap-3 px-3 py-2 text-sm font-medium text-gray-400 hover:text-white hover:bg-white/5 rounded-lg transition-base"
    end

    link_to path, class: css do
      icon = content_tag(:svg, class: "w-5 h-5 shrink-0", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
        tag.path("stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "1.5", d: icon_path)
      end
      icon + content_tag(:span, label)
    end
  end
end
