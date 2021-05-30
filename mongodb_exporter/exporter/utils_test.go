package exporter

import (
	"strings"

	"github.com/percona/exporter_shared/helpers"
)

func filterMetrics(metrics []*helpers.Metric, filters []string) []*helpers.Metric {
	res := make([]*helpers.Metric, 0, len(metrics))

	for _, m := range metrics {
		m.Value = 0
		for _, filterName := range filters {
			if m.Name == filterName {
				res = append(res, m)

				break
			}
		}
	}

	return res
}

func getMetricNames(lines []string) map[string]bool {
	names := map[string]bool{}

	for _, line := range lines {
		if strings.HasPrefix(line, "# TYPE ") {
			m := strings.Split(line, " ")
			names[m[2]] = true
		}
	}

	return names
}
