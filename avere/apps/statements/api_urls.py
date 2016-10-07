from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns

from statements.api_views import (InterestsStatementCreateAPIView,
                                  WealthStatementCreateAPIView)


app_name = 'statements'
urlpatterns = [
    url('^wealth/$', WealthStatementCreateAPIView.as_view(),
        name='wealth-create'),
    url('^interests/$', InterestsStatementCreateAPIView.as_view(),
        name='interests-create')
]

urlpatterns = format_suffix_patterns(urlpatterns)