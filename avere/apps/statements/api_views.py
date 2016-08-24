from rest_framework.generics import CreateAPIView

from statements.models import Statement
from statements.serializers import StatementSerializer


class StatementCreateAPIView(CreateAPIView):
    serializer_class = StatementSerializer

    def perform_create(self, serializer):
        Statement.objects.create(content=serializer.data)
