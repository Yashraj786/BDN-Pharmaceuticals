module ApplicationHelper
  def nav_item(label, path)
    active = current_page?(path)
    css = active ? "bg-blue-100 text-blue-800 font-bold" : "text-gray-700 hover:bg-gray-100"
    content_tag(:li) do
      link_to label, path,
        class: "flex items-center px-4 py-3 text-lg rounded-lg mx-2 #{css} transition-colors"
    end
  end

  def currency(amount)
    "₹#{number_with_delimiter(amount.to_f.round(0))}"
  end

  def status_badge(status)
    colors = {
      "in_progress"    => "bg-yellow-100 text-yellow-800",
      "completed"      => "bg-blue-100 text-blue-800",
      "quality_checked"=> "bg-purple-100 text-purple-800",
      "ready_sale"     => "bg-green-100 text-green-800",
      "pending"        => "bg-orange-100 text-orange-800",
      "partial"        => "bg-yellow-100 text-yellow-800",
      "paid"           => "bg-green-100 text-green-800",
      "delivered"      => "bg-green-100 text-green-800",
    }
    css = colors[status] || "bg-gray-100 text-gray-800"
    content_tag(:span, status.to_s.humanize, class: "#{css} px-3 py-1 rounded-full font-semibold text-base")
  end
end
