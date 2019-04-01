class BatchesService

  def initialize(params)
    @purchase_channel = params[:purchase_channel]
  end

  def call
    Batch.new(reference: Time.now.strftime("%Y%M-"<<Batch.all.size.to_s), purchase_channel: @purchase_channel)
  end

  def counter
    @batch = Batch.find_by(purchase_channel: @purchase_channel)
    count = 0
    Order.find_each do |order|
      if @purchase_channel == order[:purchase_channel]
        order[:batch_id] = @batch[:id]
        order[:status] = 1
        order.save
        count+=1
      end
    end
    @counter = count
  end
end