from django.conf import settings
from django.conf.urls import include, url
from django.contrib import admin
from django.views.generic import TemplateView


urlpatterns = [
    url(settings.ADMIN_URL, include(admin.site.urls)),
    url(r'^$', TemplateView.as_view(template_name='home.html'), name='index'),
    url(r'^accounts/', include('allauth.urls')),
    url(r'^users/', include('users.urls', namespace='users')),
    url(r'^api-auth/', include('rest_framework.urls',
                               namespace='rest_framework')),
    url(r'^api/statements/', include('statements.api_urls',
                                     namespace='statements')),
]
