class Public::SearchesController < ApplicationController
  def search
    @search_params = event_search_params  #検索結果の画面で、フォームに検索した値を表示するために、paramsの値をビューで使えるようにする
    byebug
    @events = Event.search(@search_params)#Eventモデルのsearchを呼び出し、引数としてparamsを渡している。
  end

  private

  def event_search_params
    params.fetch(:search, {}).permit(:event_name, :date_and_time_from, :date_and_time_to,)
    #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
    #ここでの:searchには、フォームから送られてくるparamsの値が入っている
  end
end
