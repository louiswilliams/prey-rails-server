device = @device
xml.instruct!
xml.device do
  xml.status do
    xml.missing device.missing?
  end
  xml.configuration do
    xml.delay device.delay
  end
  xml.modules do
    device.modules.split.each do |mod|
      xml.module :active => true, :name => mod.downcase, :type => module_type(mod) do
        xml.enabled true
      end
    end
  end
end

