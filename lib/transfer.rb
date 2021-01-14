# require './bank_account.rb'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    return sender.valid? && receiver.valid?
  end

  def execute_transaction
    if @status == "pending" && sender.balance >= @amount && sender.valid? && receiver.valid?
      receiver.deposit(@amount)
      sender.balance -= @amount
      @status = "complete"
    elsif sender.balance < @amount || !sender.valid? || !receiver.valid?
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      sender.deposit(@amount)
      receiver.balance -= @amount
      @status = "reversed" 
    end
  end
end
