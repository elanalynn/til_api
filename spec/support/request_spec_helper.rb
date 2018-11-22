module RequestSpecHelper
  def body
    JSON.parse(response.body)
  end
end
