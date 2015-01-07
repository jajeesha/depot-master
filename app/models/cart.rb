class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

   def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

def paypal_url(return_path)
    values = {
        business: "seller_4024007148673576_moorem.jajeesha@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        # item_number: order.id,
        quantity: '1'
    }

     values.merge!({
        "amount_#{0 + 1}" => 40,
        "item_name_#{0 + 1}" => 'my_product',
        "item_number_#{0 + 1}" => 'testifasdf',
        "quantity_#{0 + 1}" => 2
      })

    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end



end
 