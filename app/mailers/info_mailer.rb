class InfoMailer < ApplicationMailer

  def info_mail(participant, info)
    @participat = participant
    @info = info
    mail to: participant.email, subject: '【虫めがね村】 イベントの詳細'
  end

end
