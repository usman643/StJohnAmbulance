//
//  ENTALDConfigModel.swift
//  ENTALDO
//
//  Created by M.Usman on 26/04/2022.
//

import Foundation

struct ENTALDConfigModel: Codable {
    let license_agreement: String?
    let privacy_policy: String?
    let help_and_live_chat: String?
    let faqs: String?
    let demographics_form_cancelable: String?
    let demographics_is_active: String?
    let is_captcha_verification: Bool?
    let is_s_p: String?
    let countries_version: String?
    let filters_version: String?
    let terms_and_conditions: String?
    let instruction_screen_text_1: String?
    let instruction_screen_url_1: String?
    let instruction_screen_text_2: String?
    let instruction_screen_url_2: String?
    let instruction_screen_text_3: String?
    let instruction_screen_url_3: String?
    let instruction_screen_text_4: String?
    let instruction_screen_url_4: String?
    let instruction_screen_text_5: String?
    let instruction_screen_url_5: String?
    let email_service_enabled: Bool?
    let contact_email: String?
    let gdpr_consent_title: String?
    let gdpr_consent_message: String?
    let gdpr_consent_yes: String?
    let gdpr_consent_no: String?
    let enable_signature_encryption: Bool?
    let tutorials_max_allowed_sessions: String?
    let terms_and_conditions_ar: String?
    
    let yas_benefits_group_for_residents: String?
    let yas_benefits_group_for_employees: String?
    let points_gifting_denominations: String?
    let point_gifting_notification_title: String?
    let point_gifting_notification_desc: String?
    let charity_donation_denominations: String?
    let charity_donation_deeplink: String?
    
    let refer_a_friend_share_text: String?
    let refer_a_friend_message: String?
    let refer_a_friend_button_title: String?
    let promocode_x_success_message: String?
    let promocode_x_used_message: String?
    let ADR_444_success_message: String?
    let ADR_444_used_message: String?
    let ADR_444_expired_message: String?
    let ADR_444_invalid_message: String?
    let invalid_promocode_message: String?
    let tag_type_points: String?
    let tag_type_rewards: String?
}

struct ENTALDLocationConfigModel:Codable {
    let id: String?
    let name: String?
    let currency: String?
}

struct ENTALDTutorialsModel:Codable {
    let identifier: String?
    let title: String?
    let description: String?
}
