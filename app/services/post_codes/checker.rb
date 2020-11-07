module PostCodes
  class Checker
    def initialize(code)
      @code = code
    end

    def call
      return PostCodes::Struct.new(code: @code, valid: true) if Cacher.get(@code)

      req = call_external_service
      Cacher.set(@code) if req.response_successful?
      @post_code = PostCodes::Struct.new(code: @code, valid: req.response_successful?)
    rescue External::Errors::RequestFailure
      allowed = @code.in? AllowedList.pluck(:code)
      cacher.set(@code) if allowed

      @post_code = PostCodes::Struct.new(code: @code, valid: allowed)
    end

    private

    def call_external_service
      req = External::Requests::PostCodesIo.new(@code)
      req.call
      req
    end
  end
end
