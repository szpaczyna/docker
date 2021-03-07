package quay

import (
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"

	"github.com/jetstack/version-checker/pkg/api"
)

const (
	lookupURL = "https://quay.io/api/v1/repository/%s/%s/tag/"
)

type Options struct {
	Token string
}

type Client struct {
	*http.Client
	Options
}

type Response struct {
	Tags []Tag `json:"tags"`
}

type Tag struct {
	Name           string `json:"name"`
	ManifestDigest string `json:"manifest_digest"`
	LastModified   string `json:"last_modified"`
}

func New(opts Options) *Client {
	return &Client{
		Options: opts,
		Client: &http.Client{
			Timeout: time.Second * 5,
		},
	}
}

func (c *Client) Name() string {
	return "quay"
}

func (c *Client) Tags(ctx context.Context, _, repo, image string) ([]api.ImageTag, error) {
	url := fmt.Sprintf(lookupURL, repo, image)

	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return nil, err
	}

	if len(c.Token) > 0 {
		req.Header.Add("Authorization", "Bearer "+c.Token)
	}

	req.URL.Scheme = "https"
	req = req.WithContext(ctx)

	resp, err := c.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to get quay image: %s", err)
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	var response Response
	if err := json.Unmarshal(body, &response); err != nil {
		return nil, err
	}

	var tags []api.ImageTag
	for _, tag := range response.Tags {
		timestamp, err := time.Parse(time.RFC1123Z, tag.LastModified)
		if err != nil {
			return nil, err
		}

		tags = append(tags, api.ImageTag{
			Tag:       tag.Name,
			SHA:       tag.ManifestDigest,
			Timestamp: timestamp,
		})
	}

	return tags, nil
}
