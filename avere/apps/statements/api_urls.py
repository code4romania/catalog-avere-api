from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns

from statements.api_views import StatementCreateAPIView


app_name = 'statements'
urlpatterns = [
    url('^$', StatementCreateAPIView.as_view(), name='create')
]

urlpatterns = format_suffix_patterns(urlpatterns)