class InfoMailer < ApplicationMailer

  def info_mail(info, participant)
    @participant = participant
    @info = info
    mail(to: @participant.email, subject: '【虫めがね村】 イベントの詳細', body: @info.message)
  end

end
