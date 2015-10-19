site :reims do |site_uid|
  3.times do |i|
    pdu "stremi-pdu#{i+1}" do |pdu_uid|
      vendor "Raritan"
      model ""
      sensors [
        {
          :power => {
            :per_outlets => true,
            :snmp => {
              :available => true,
              :total_oids => "iso.3.6.1.4.1.13742.4.1.3.1.3.0",
              :unit => "W",
              :outlet_prefix_oid => "iso.3.6.1.4.1.13742.4.1.2.2.1.7"
            }
          }
        }
      ]
    end
  end
end