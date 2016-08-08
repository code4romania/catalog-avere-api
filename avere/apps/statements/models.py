# -*- coding:utf-8 -*-

from __future__ import unicode_literals

from django.core.urlresolvers import reverse
from django.db import models
from django.utils.encoding import python_2_unicode_compatible


@python_2_unicode_compatible
class Statement(models.Model):
    first_name = models.CharField(verbose_name='prenume', max_length=255)
    last_name = models.CharField(verbose_name='nume', max_length=255)
    position = models.CharField(verbose_name='funcție', max_length=255)
    position_location = models.CharField(
        verbose_name='locul funcției',
        max_length=255,
    )
    created = models.DateField(auto_now_add=True)

    def get_absolute_url(self):
        return reverse('statements:detail', kwargs={'pk': self.pk})

    def __str__(self):
        return '<%s %s - %s>' % (self.first_name, self.last_name, self.position)
