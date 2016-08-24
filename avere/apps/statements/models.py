# coding=utf-8
from __future__ import unicode_literals

from django.contrib.postgres.fields import JSONField
from django.core.urlresolvers import reverse
from django.db import models
from django.utils.encoding import python_2_unicode_compatible


@python_2_unicode_compatible
class Statement(models.Model):
    content = JSONField()

    def get_absolute_url(self):
        return reverse('statements:detail', kwargs={'pk': self.pk})

    def __str__(self):
        return '<%s>' % (self.pk,)
