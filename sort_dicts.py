from collections.abc import Mapping
from operator import itemgetter
from typing import TypeVar

K = TypeVar("K")
V = TypeVar("V")


def sort_dicts_by_key(
    dictionaries: list[Mapping[K, V]],
    key: K,
    *,
    reverse: bool = False,
) -> list[Mapping[K, V]]:
    """Возвращает новый список словарей, отсортированный по значению ключа."""
    return sorted(dictionaries, key=itemgetter(key), reverse=reverse)
