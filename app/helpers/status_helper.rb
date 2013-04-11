module StatusHelper

  REPORT_MODULES = %w(geo network session webcam)

  def module_type(mod)
    REPORT_MODULES.include?(mod.downcase) ? 'report' : 'action'
  end
end
