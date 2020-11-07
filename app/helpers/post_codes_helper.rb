module PostCodesHelper
  def decorate_validity(valid)
    valid ? 'allowed' : 'not allowed'
  end
end
