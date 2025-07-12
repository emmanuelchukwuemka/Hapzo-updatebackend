from ...users.infrastructure.factory import get_user_repository
from ..application.rules import (
    EmailOTPRequestRule,
    LoginRule,
    LogoutRule,
    RegisterRule,
    ResetPasswordRule,
    VerifyEmailRule,
)
from ..infrastructure.repositories import DjangoOTPCodeRepository
from ..infrastructure.services import (
    DjangoEmailServiceAdapter,
    DjangoPasswordServiceAdapter,
    KnoxAuthenticationServiceAdapter,
)


def get_password_service() -> DjangoPasswordServiceAdapter:
    return DjangoPasswordServiceAdapter()


def get_email_service() -> DjangoEmailServiceAdapter:
    return DjangoEmailServiceAdapter()


def get_otp_code_repository() -> DjangoOTPCodeRepository:
    return DjangoOTPCodeRepository()


def get_authentication_service() -> KnoxAuthenticationServiceAdapter:
    return KnoxAuthenticationServiceAdapter()


def get_register_rule() -> RegisterRule:
    return RegisterRule(
        user_repository=get_user_repository(), password_service=get_password_service()
    )


def get_email_otp_request_rule() -> EmailOTPRequestRule:
    return EmailOTPRequestRule(
        user_repository=get_user_repository(),
        otp_code_repository=get_otp_code_repository(),
        email_service=get_email_service(),
    )


def get_login_rule() -> LoginRule:
    return LoginRule(
        user_repository=get_user_repository(),
        password_service=get_password_service(),
        authentication_service=get_authentication_service(),
    )


def get_logout_rule() -> LogoutRule:
    return LogoutRule(
        authentication_service=get_authentication_service(),
    )


def get_reset_password_rule() -> ResetPasswordRule:
    return ResetPasswordRule(
        otp_code_repository=get_otp_code_repository(),
        user_repository=get_user_repository(),
        password_service=get_password_service(),
    )


def get_verify_email_rule() -> VerifyEmailRule:
    return VerifyEmailRule(
        user_repository=get_user_repository(),
        otp_code_repository=get_otp_code_repository(),
    )
