from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView
from django.views.generic.list import ListView

from statements.forms import StatementForm
from statements.models import Statement


class StatementDetailView(DetailView):
    model = Statement


class StatementCreateView(CreateView):
    model = Statement
    form_class = StatementForm


class StatementUpdateView(UpdateView):
    model = Statement
    form_class = StatementForm


class StatementListView(ListView):
    model = Statement
