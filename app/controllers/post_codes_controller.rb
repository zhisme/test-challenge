class PostCodesController < ApplicationController
  attr_reader :post_code

  helper_method :post_code

  def index; end

  def create
    respond_to do |format|
      format.js do
        validation = PostCodes::Validation.(permitted_params.to_h)

        @post_code = if validation.success?
                       PostCodes::Checker.new(permitted_params[:code]).call
                     else
                       PostCodes::Struct.new(permitted_params.to_h.symbolize_keys)
                     end
      end
    end
  end

  private

  def permitted_params
    params.require(:post_codes_form).permit(:code)
  end
end
