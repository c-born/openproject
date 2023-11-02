# frozen_string_literal: true

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++
#
module Storages::Admin::Forms
  class AutomaticallyManagedProjectFoldersFormComponent < ApplicationComponent
    include OpPrimer::ComponentHelpers
    alias_method :storage, :model

    def form_method
      options[:form_method] || default_form_method
    end

    def form_url
      options[:form_url] || default_form_url
    end

    private

    def default_form_method
      storage.automatic_management_unspecified? ? :post : :patch
    end

    def default_form_url
      admin_settings_storage_automatically_managed_project_folders_path(storage)
    end

    def storage_provider_credentials_copy_instructions
      "#{I18n.t('storages.instructions.copy_from')}: #{provider_credentials_instructions_link}".html_safe
    end

    def provider_credentials_instructions_link
      render(
        Primer::Beta::Link.new(
          href: Storages::Peripherals::StorageInteraction::Nextcloud::Util.join_uri_path(storage.host,
                                                                                         'settings/admin/openproject'),
          target: '_blank'
        )
      ) { I18n.t("storages.instructions.#{storage.short_provider_type}.integration") }
    end
  end
end
