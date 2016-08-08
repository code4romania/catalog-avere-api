# -*- encoding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from django.conf.urls import url

from statements.views import (StatementCreateView, StatementUpdateView,
                              StatementDetailView, StatementListView)

app_name = 'statements'
urlpatterns = [
    url(
        regex=r'declaratii$',
        view=StatementListView.as_view(),
        name='list',
    ),
    url(
        regex=r'^declaratii/(?P<pk>[0-9]+)$',
        view=StatementDetailView.as_view(),
        name='detail'
    ),
    url(
        regex=r'^declaratii/adauga/$',
        view=StatementCreateView.as_view(),
        name='create'
    ),
    url(
        regex=r'^declaratii/editeaza/(?P<pk>[0-9]+)/$',
        view=StatementUpdateView.as_view(),
        name='update'
    ),
]