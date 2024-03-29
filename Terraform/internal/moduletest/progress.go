// Copyright (c) HashiCorp, Inc.
// SPDX-License-Identifier: BUSL-1.1

package moduletest

// Progress represents the status of a test file as it executes.
//
// We will include the progress markers to provide feedback as each test file
// executes.
//
//go:generate go run golang.org/x/tools/cmd/stringer -type=Progress progress.go
type Progress int

const (
	Starting Progress = iota
	TearDown
	Complete
)
