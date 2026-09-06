# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    banner_classes = 'aa:mb-6 aa:flex aa:items-center aa:justify-between aa:rounded-xl ' \
                     'aa:bg-indigo-50 aa:p-5 aa:ring-1 aa:ring-indigo-100'
    status_classes = 'aa:rounded-full aa:bg-emerald-100 aa:px-3 aa:py-1 aa:text-xs ' \
                     'aa:font-semibold aa:text-emerald-700'

    div class: banner_classes do
      div do
        h2 'Admin workspace', class: 'aa:m-0 aa:text-lg aa:font-semibold aa:text-indigo-950'
        para 'Tailwind CSS utilities are available in ActiveAdmin with the aa: prefix.',
             class: 'aa:mt-1 aa:mb-0 aa:text-sm aa:text-indigo-700'
      end
      span 'Ready', class: status_classes
    end

    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel 'Recent Posts' do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel 'Info' do
    #       para 'Welcome to ActiveAdmin.'
    #     end
    #   end
    # end
  end
end
