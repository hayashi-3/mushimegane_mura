class InfoMailer < ApplicationMailer

  def info_mail(participant, info)
    @participant = participant
    @info = info
    mail(to: @participant, subject: '【虫めがね村】 イベントの詳細')
  end

end
