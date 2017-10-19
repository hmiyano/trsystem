# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).

crumb :root do
  link "ダッシュボード", root_path
end
 
# trainee#index
crumb :trainees do
  link "トレーニー", trainees_path
  parent :root
end
 
# trainee#show
crumb :trainee do |trainee|
  link trainee.name, trainee
  parent :trainees
end
 
# trainee#edit
crumb :edit_trainee do |trainee|
  link "編集 #{trainee.name}", edit_trainee_path(trainee)
  parent :trainee, trainee
end
 
# trainee#new
crumb :new_trainee do
  link "トレーニー新規登録", new_trainee_path
  parent :trainees
end

# trainer#index
crumb :trainers do
  link "トレーナー", trainers_path
  parent :root
end
 
# trainer#show
crumb :trainer do |trainer|
  link trainer.name, trainer
  parent :trainers
end
 
# trainer#edit
crumb :edit_trainer do |trainer|
  link "編集 #{trainer.name}", edit_trainer_path(trainer)
  parent :trainer, trainer
end
 
# trainer#new
crumb :new_trainer do
  link "トレーナー新規登録", new_trainer_path
  parent :trainers
end

# admin#index
crumb :admins do
  link "管理者", admins_path
  parent :root
end
 
# admin#show
crumb :admin do |admin|
  link admin.name, admin
  parent :admins
end
 
# admin#edit
crumb :edit_admin do |admin|
  link "編集 #{admin.name}", edit_admin_path(admin)
  parent :admin, admin
end
 
# admin#new
crumb :new_admin do
  link "管理者新規登録", new_admin_path
  parent :admins
end

