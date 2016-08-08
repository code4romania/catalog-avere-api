from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView
from django.views.generic.list import ListView

from statements.forms import StatementForm
from statements.models import Statement


class StatementDetailView(DetailView):
    context_object_name = 'statement'
    model = Statement


class StatementCreateView(CreateView):
    model = Statement
    form_class = StatementForm


class StatementUpdateView(UpdateView):
    model = Statement
    form_class = StatementForm


class StatementListView(ListView):
    context_object_name = 'statement_list'
    model = Statement
