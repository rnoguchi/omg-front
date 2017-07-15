class ApplicationController < ActionController::Base
  def outputLog(e)
    logger.fatal "----------- エラー発生 -------------"
    logger.fatal e.message
    logger.fatal e.backtrace.join("\n")
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
