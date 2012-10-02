module GetResponse

  class Newsletter < Message
    
    def initialize(params, connection)

      @campaign_id = params["campaign_id"]
      @from_field = params["from_field"]
      @reply_to_field = params["reply_to_field"]
      @contacts = params["contacts"]

      super(params, connection)
    end
    
    #TODO returned value + units
    def send(contacts)
      params = {"campaign" => @campaign_id, "from_field" => @from_field, "reply_to_field" => @reply_to_field, "subject" => @subject, "contents" => {"plain" => @text_content, "html" => @html_content }, "contacts" => contacts}
      resp = @connection.send_request("send_newsletter", params)
      
    end
    
    # Delete newsletter. You can delete only newsletters that have send_on date in future. If you try
    # to delete exception will be raised.
    def destroy
      resp = @connection.send_request("delete_newsletter", :message => @id)["result"]
      resp["deleted"].to_i == 1
    end

  end

end

