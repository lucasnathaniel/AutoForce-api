#Class for Batches Controller methods: financial_report

class FinancialService  
  def initialize(purchase_channel_)
    @count = 0
    @sum = 0
    @batch = Batch.find_by(purchase_channel: purchase_channel_)
  end

  def report
    Order.find_each do |order|
      if order[:batch_id] == @batch[:id]
        @count += 1
        @sum += order[:total_value]
      end
    end
    @report = @batch.as_json.merge(count_orders: @count, total_value_report: @sum)
  end

end
